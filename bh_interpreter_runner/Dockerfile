FROM node:lts-bullseye

ARG DOCKER_GID=999

# Install dependencies 
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y vim && \
    apt-get install -y build-essential && \
    apt-get install -y libssl-dev && \
    apt-get install -y libffi-dev && \
    apt-get install -y python3 && \
    apt-get install -y python3-venv && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-pip && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y jq && \
    apt-get install -y iputils-ping && \
    apt-get install -y apt-transport-https && \
    apt-get install -y gnupg && \
    apt-get install -y lsb-release && \
    apt-get install -y ca-certificates && \
    apt-get install -y gnupg-agent && \
    apt-get install -y software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Add docker group
RUN groupadd -g ${DOCKER_GID} docker

# Add user
RUN useradd -m -d /home/vscode -s /bin/bash vscode && \
    usermod -aG docker vscode
# Set permissions
RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/vscode
RUN mkdir -p /home/vscode/work
RUN chown -R vscode /usr/local

# Install GitHub runner
RUN mkdir actions-runner && \
    cd actions-runner && \
    curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz && \
    echo "292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f  actions-runner-linux-x64-2.304.0.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz && \
    ./bin/installdependencies.sh

WORKDIR actions-runner
COPY --chown=vscode:vscode runner.bash .
RUN sudo chmod +x runner.bash
RUN chown -R vscode /home/vscode
USER vscode

# Start runner
CMD ./runner.bash