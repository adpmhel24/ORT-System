from datetime import date, datetime
import random


class BaseReference:
    def __init__(self, basetype: str):
        self.basetype = basetype

    def reference(self):
        # Get the current timestamp
        timestamp = datetime.now().timestamp()

        # Set the random seed based on the timestamp
        random.seed(timestamp)

        # Generate a random number
        random_number = random.randint(0, 100)
        return f"{self.basetype}-{random_number}"
