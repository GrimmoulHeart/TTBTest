pipeline {
    agent any
    environment {
        ROBOT_RESULTS = "results" 
    }

    stages {
        stage('Checkout Code From Git') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/GrimmoulHeart/TTBTest.git']]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m pip install --upgrade pip
                pip3 install robotframework
                pip3 install robotframework-seleniumlibrary
                pip3 install robotframework-appiumlibrary
                pip3 install robotframework-requests
                '''
            }
        }

        stage('Run Test Automate') {
            steps {
                sh '''
                export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
                export ANDROID_HOME=/Users/terayutjentanomma/Library/Android/sdk
                export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
                export JAVA_HOME=$(/usr/libexec/java_home)
                export PATH=$JAVA_HOME/bin:$PATH
                ls -R /Users/terayutjentanomma/.jenkins/workspace/DemoTTB
                mkdir -p ${ROBOT_RESULTS}
                robot -d ${ROBOT_RESULTS} /Users/terayutjentanomma/.jenkins/workspace/DemoTTB/2.Logintest.robot
                robot -d ${ROBOT_RESULTS} /Users/terayutjentanomma/.jenkins/workspace/DemoTTB/3.APItest.robot
                '''
            }
        }
        stage('Send Result To Jenkins') {
            steps {
                robot archiveDirName: 'robot-plugin', outputPath: 'results', overwriteXAxisLabel: '', passThreshold: 50.0, unstableThreshold: 80.0
            }
        }
    }
    
}
