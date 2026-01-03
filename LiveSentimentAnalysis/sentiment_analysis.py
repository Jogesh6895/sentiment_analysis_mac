import sys
from textblob import TextBlob


class Sentiment_Analysis:

    def __init__(self, sentence):
        self.in_sent = sentence


    def get_sentiment_score(self):
        testimonial = TextBlob(self.in_sent)
        return round(testimonial.sentiment.polarity,2)
 

if __name__ == "__main__":
    if len(sys.argv) == 2:
        sentiment_obj = Sentiment_Analysis(sys.argv[1])
        print(sentiment_obj.get_sentiment_score())
    else:
        print("Invalid Number of Arguments to Sentiment Analysis Program.")
