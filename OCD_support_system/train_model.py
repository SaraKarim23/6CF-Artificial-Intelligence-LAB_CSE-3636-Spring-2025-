import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer # type: ignore
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
import joblib

# Load and balance dataset
df = pd.read_csv('ocd_dataset_with_nonocd.csv')

# Add data augmentation here if needed

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    df['text'], df['label'], test_size=0.2, random_state=42, stratify=df['label'])

# Vectorize text with better parameters
vectorizer = TfidfVectorizer(
    max_features=5000,
    ngram_range=(1, 2),  # Consider word pairs
    stop_words='english'
)

X_train_vec = vectorizer.fit_transform(X_train)
X_test_vec = vectorizer.transform(X_test)

# Train improved model
model = LogisticRegression(
    max_iter=1000,
    class_weight='balanced'  # Handles imbalanced data
)
model.fit(X_train_vec, y_train)

# Evaluate
print("Test accuracy:", model.score(X_test_vec, y_test))
print(classification_report(y_test, model.predict(X_test_vec)))

# Save model and vectorizer
joblib.dump(model, 'ocd_model.pkl')
joblib.dump(vectorizer, 'vectorizer.pkl')