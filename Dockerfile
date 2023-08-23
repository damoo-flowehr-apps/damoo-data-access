#  Copyright (c) University College London Hospitals NHS Foundation Trust
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye

# Create and run commands in /app inside the container
WORKDIR /app

# Install pip
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-pip

# Copy the required files into the working directory
COPY /api/ /app/api/

# Install the Python dependencies
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --upgrade pip && \
    pip install -r api/requirements.txt



# Build UI
COPY /ui/ /app/ui/
WORKDIR /app/ui
RUN yarn build

# Create and use a non-root user
RUN useradd -m appUser
USER appUser


# Serve the app on port 8000
WORKDIR /app/api
CMD uvicorn main:app
