FROM python:3.11-slim

# Create a non-root user and group for security hardening
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set working directory
WORKDIR /app

# Copy application files (if any) or set permissions
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Default command placeholder
CMD ["python", "-c", "print('Running securely as non-root user!')"]
