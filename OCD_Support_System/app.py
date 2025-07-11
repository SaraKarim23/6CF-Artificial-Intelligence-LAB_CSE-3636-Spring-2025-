from flask import Flask, request, jsonify, render_template
import joblib
import random
from datetime import datetime
import os
import json

app = Flask(__name__)

# Load model and vectorizer
model = joblib.load('ocd_model.pkl')
vectorizer = joblib.load('vectorizer.pkl')

# Conversation states
CONVERSATION_STATES = {
    'GREETING': 0,
    'LISTENING': 1,
    'OFFERING_HELP': 2,
    'PROVIDING_TASK': 3
}

RESPONSES = {
    'greeting': [
        "Hello! I'm here to help with OCD-related concerns. How are you feeling today?"
    ],
    'ask_problem': [
        "I'm here to listen. Can you tell me more about what's bothering you?",
        "Would you like to share what's been causing you distress?"
    ],
    'positive': [
        "That's great to hear! If you ever want to talk or need support, I'm here for you."
    ],
    'ocd_detected': [
        "From what you're describing, I notice some patterns that might relate to OCD. Would you like me to suggest a helpful activity?",
        "I understand this might be difficult and similar to OCD. I can suggest something that might help if you'd like."
    ],
    'no_ocd': [
        "That sounds like a normal thought! I'm here if you want to chat about anything else.",
        "Thanks for sharing. It's good to just acknowledge thoughts sometimes.",
        "Sounds like a typical thought. What else is on your mind?",
        "That's a common experience. Is there anything else you'd like to discuss?"
    ],
    'task_accepted': [
        "Here's something that might help:",
        "I suggest trying this activity:"
    ],
    'task_declined': [
        "That's completely okay. I'm here if you change your mind.",
        "No problem at all. Remember I'm here if you need support later."
    ],
    'closing': [
        "Remember, I'm here if you need to talk more. Take care!",
        "Wishing you a peaceful day. Goodbye!"
    ]
}

OCD_TASKS = [
    {"title": "5-4-3-2-1 Grounding", "description": "Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, and 1 you can taste."},
    {"title": "Delayed Response", "description": "Find an object near you. Spend one minute observing it with curiosity. Notice its color, texture, shape, and any other details."},
    {"title": "Thought Labeling", "description": "When an intrusive thought comes, label it as 'just a thought' and let it pass without engaging."}
]

POSITIVE_KEYWORDS = [
    "good", "fine", "happy", "great", "well", "okay", "awesome", "fantastic", "excellent", "amazing", "not bad", "doing well"
]
GREETING_KEYWORDS = [
    "hi", "hello", "hey", "greetings", "good morning", "good afternoon", "good evening"
]
GOODBYE_KEYWORDS = [
    "bye", "goodbye", "thanks", "thank you", "see you", "take care", "farewell"
]

HISTORY_FILE = 'conversation_history.json'

def get_conversation_history():
    if os.path.exists(HISTORY_FILE):
        with open(HISTORY_FILE, 'r') as f:
            return json.load(f)
    return []

def save_conversation(conversation):
    history = get_conversation_history()
    history.append(conversation)
    with open(HISTORY_FILE, 'w') as f:
        json.dump(history, f)

def is_positive(message):
    return any(word in message.lower() for word in POSITIVE_KEYWORDS)

def is_greeting(message):
    return any(word in message.lower() for word in GREETING_KEYWORDS)

def is_goodbye(message):
    return any(word in message.lower() for word in GOODBYE_KEYWORDS)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/history')
def get_history():
    return jsonify(get_conversation_history())

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    user_input = data.get('message', '').lower().strip()
    conversation_id = data.get('conversation_id', None)
    current_state = data.get('state', CONVERSATION_STATES['GREETING'])

    response = {
        "reply": "",
        "tasks": [],
        "state": current_state,
        "conversation_id": conversation_id,
        "timestamp": datetime.now().strftime("%H:%M"),
        "offer_help": False
    }

    # Start new conversation only if user sends something meaningful
    if not conversation_id:
        conversation_id = datetime.now().strftime("%Y%m%d%H%M%S")
        response['conversation_id'] = conversation_id

        if user_input:  # Only reply if user typed something
            if is_greeting(user_input):
                response['reply'] = random.choice(RESPONSES['greeting'])
                response['state'] = CONVERSATION_STATES['GREETING']
            elif is_positive(user_input):
                response['reply'] = random.choice(RESPONSES['positive'])
                response['state'] = CONVERSATION_STATES['GREETING']
            else:
                response['reply'] = random.choice(RESPONSES['ask_problem'])
                response['state'] = CONVERSATION_STATES['LISTENING']
        else:
            # No greeting unless user types something
            response['reply'] = ""
            response['state'] = CONVERSATION_STATES['GREETING']
        return jsonify(response)

    # Handle goodbye
    if is_goodbye(user_input):
        response['reply'] = random.choice(RESPONSES['closing'])
        response['state'] = CONVERSATION_STATES['GREETING']
        return jsonify(response)

    # Handle greeting at any point
    if is_greeting(user_input):
        response['reply'] = random.choice(RESPONSES['greeting'])
        response['state'] = CONVERSATION_STATES['GREETING']
        return jsonify(response)

    # State transitions
    if current_state == CONVERSATION_STATES['GREETING']:
        if is_positive(user_input):
            response['reply'] = random.choice(RESPONSES['positive'])
            response['state'] = CONVERSATION_STATES['GREETING']
        else:
            response['reply'] = random.choice(RESPONSES['ask_problem'])
            response['state'] = CONVERSATION_STATES['LISTENING']

    elif current_state == CONVERSATION_STATES['LISTENING']:
        if is_positive(user_input):
            response['reply'] = random.choice(RESPONSES['positive'])
            response['state'] = CONVERSATION_STATES['GREETING']
        else:
            X_vec = vectorizer.transform([user_input])
            prediction = model.predict(X_vec)[0]
            if prediction == 0:
                response['reply'] = random.choice(RESPONSES['ocd_detected'])
                response['state'] = CONVERSATION_STATES['OFFERING_HELP']
                response['offer_help'] = True
            else:
                response['reply'] = random.choice(RESPONSES['no_ocd'])
                response['state'] = CONVERSATION_STATES['LISTENING']

    elif current_state == CONVERSATION_STATES['OFFERING_HELP']:
         if user_input.strip() in ['yes', 'yeah', 'sure', 'ok', 'please']:
              response['reply'] = random.choice(RESPONSES['task_accepted'])
              response['tasks'] = [random.choice(OCD_TASKS)]
              response['state'] = CONVERSATION_STATES['PROVIDING_TASK']
         else:
             response['reply'] = random.choice(RESPONSES['task_declined'])
             response['state'] = CONVERSATION_STATES['GREETING']
    

    elif current_state == CONVERSATION_STATES['PROVIDING_TASK']:
        response['reply'] = "How are you feeling now? Would you like another suggestion?"
        response['state'] = CONVERSATION_STATES['OFFERING_HELP']
        response['offer_help'] = True

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
