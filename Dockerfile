# Use official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Default command when container runs
CMD ["sh", "-c", "echo '=== Running EKF ===' && python localization.py ekf --seed 0 --plot && echo -e '\\n\\n=== Running PF ===' && python localization.py pf --seed 0"]

