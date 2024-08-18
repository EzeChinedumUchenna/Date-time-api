FROM python:3.9-slim

# Set environment variables to prevent Python from writing .pyc files and buffering stdout and stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create a non-root user and group, and create the /app directory
RUN groupadd -r appuser && useradd -r -g appuser appuser && mkdir /app && chown -R appuser:appuser /app

# Set the working directory inside the container
WORKDIR /app

# Copy the Flask app into the container..
COPY . /app/

# Install Flask as root
RUN pip install --no-cache-dir Flask

# Switch to the non-root user
USER appuser

# Expose the port that the app will run on
EXPOSE 5000

# Run the Flask application
CMD ["python", "data-time-app.py"]
