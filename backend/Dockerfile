FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM python:3.11-slim
WORKDIR /app

RUN useradd -m appuser
RUN mkdir -p /app && chown -R appuser:appuser /app

USER appuser

COPY --from=builder /root/.local /home/appuser/.local
COPY . .

ENV PATH="/home/appuser/.local/bin:$PATH"
ENV DJANGO_SETTINGS_MODULE=config.settings

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
