FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY src/ .

# Generate QR codes volume
VOLUME ["/app/qr_codes"]

# Run app
CMD ["python", "app.py"]

EXPOSE 3000 8080