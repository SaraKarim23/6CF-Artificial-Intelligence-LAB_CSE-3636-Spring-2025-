from flask import Flask, render_template, request, jsonify
import random
import json
import torch
from model import NeuralNet
from nltk_utils import tokenize, bag_of_words

app = Flask(__name__)

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

with open('intents.json', 'r') as f:
    intents = json.load(f)

FILE = "data.pth"
data = torch.load(FILE)

input_size = data["input_size"]
hidden_size = data["hidden_size"]
output_size = data["output_size"]
all_words = data['all_words']
tags = data['tags']
model_state = data["model_state"]

model = NeuralNet(input_size, hidden_size, output_size).to(device)
model.load_state_dict(model_state)
model.eval()

@app.route('/')
def home():
    return render_template('base.html')

@app.route('/chat', methods=['POST'])
def chat():
    sentence = request.json.get('message')
    print(f"User message: {sentence}")

    if not sentence:
        return jsonify({'reply': "Sorry, I didn't get that."})

    sentence_tokens = tokenize(sentence)
    print(f"Tokenized: {sentence_tokens}")

    X = bag_of_words(sentence_tokens, all_words)
    print(f"Bag of Words: {X}")

    X = torch.from_numpy(X).unsqueeze(0).to(device)

    output = model(X)
    _, predicted = torch.max(output, dim=1)

    tag = tags[predicted.item()]
    print(f"Predicted tag: {tag}")

    probs = torch.softmax(output, dim=1)
    prob = probs[0][predicted.item()]
    print(f"Confidence: {prob.item()}")

    threshold = 0.6  # তুমি চাইলে 0.75 থেকে কমিয়ে 0.6 করতে পারো
    if prob.item() > threshold:
        for intent in intents['intents']:
            if intent['tag'] == tag:
                reply = random.choice(intent['responses'])
                print(f"Reply: {reply}")
                return jsonify({'reply': reply})

    return jsonify({'reply': "I do not understand... Can you rephrase?"})

if __name__ == '__main__':
    app.run(debug=True)
