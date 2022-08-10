FROM python:3.10-slim

ARG POETRY_VERSION

# Install Poetry
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /app

COPY ./app /app/

# Install packages
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]