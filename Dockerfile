FROM ubuntu:22.04

ARG DOCKER_GID=999

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y jq && \
    apt-get install -y iputils-ping && \
    apt-get install -y apt-transport-https && \
    apt-get install -y ca-certificates && \
    apt-get install -y gnupg-agent && \
    apt-get install -y software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Add docker group
RUN groupadd -g ${DOCKER_GID} docker

# Add user
RUN useradd -m -d /home/runner -s /bin/bash runner && \
    usermod -aG docker runner

# Install GitHub runner
RUN mkdir actions-runner && \
    cd actions-runner && \
    curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz && \
    echo "292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f  actions-runner-linux-x64-2.304.0.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz && \
    ./bin/installdependencies.sh

WORKDIR actions-runner
RUN chown -R runner .
USER runner

# Start runner
CMD ./config.sh --url $REPOSITORY_URL --token $ACCESS_TOKEN --name $RUNNER_NAME --work $WORK_DIRECTORY --labels $LABELS && ./run.sh