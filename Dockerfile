FROM apache/spark-py:v3.4.0
# Set environment variables to avoid interactive prompts

USER root
SHELL ["/bin/bash", "-c"]

ENV PATH="/root/anaconda3/bin:${PATH}"
ARG PATH="/root/anaconda3/bin:${PATH}"

# Download and install Anaconda
RUN apt-get update
RUN apt-get install -y wget
# RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
COPY Dependencies/Anaconda3-2023.07-2-Linux-x86_64.sh ./
#install in PATH
RUN bash Anaconda3-2023.07-2-Linux-x86_64.sh -b 
RUN rm Anaconda3-2023.07-2-Linux-x86_64.sh

# Create a Python 3.9 environment
RUN conda create -n myenv python=3.9

# Activate the environment
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]
# Set the default command to run when the container starts
WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# CMD [ "python", "app.py" ]
CMD ["conda", "activate", "myenv"]