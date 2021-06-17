pipeline {
    agent {label 'jslave'}
      stages {
        stage('GitHub clone') {
         steps {
                git credentialsId: 'github-key', url: 'git@github.com:Areandill/JenkinsGit.git'
            }
            }
        
         stage('Move Files') {
         steps {
                script{
                sh """ 
                 mv index.html /etc/ansible/
                 mv playbook.yml /etc/ansible/
                 mv main.tf /usr/bin/terraform/ 
                 mv variables.tf /usr/bin/terraform/
                 """
            }  
            }
        }
      
        stage('Terraform') {
            steps {
            withCredentials([aws(accessKeyVariable: "AWS_ACCESS_KEY_ID", credentialsId: "ter-aws-cred", secretKeyVariable: "AWS_SECRET_ACCESS_KEY")]) {
                script {
                sh """
                cd /usr/bin/terraform/
                ./terraform init
                ./terraform plan -var="access_key=$AWS_ACCESS_KEY_ID" -var="secret_key=$AWS_SECRET_ACCESS_KEY" -input=false -out=/usr/bin/terraform/plan
                ./terraform apply -auto-approve "plan"
                """
                }
            }
            }
         }
      stage('Ip for Ansible') {
            environment {
                PUB_IP = sh(script:"""
                cd /usr/bin/terraform/
                /usr/bin/terraform/terraform output -raw pub_ips """, returnStdout: true)
                }
            steps {    
            script {
                    sh 'echo Ubuntu ansible_host="$PUB_IP" ansible_python_interpreter=/usr/bin/python3 ansible_ssh_user=ubuntu >> /etc/ansible/hosts'
                    }
            }
        }
         stage('Ansible playbook') {   
            steps {
                 withCredentials([file(credentialsId: 'pem', variable: 'key')]) {
                    sh """ 
                    export ANSIBLE_HOST_KEY_CHECKING=False
                    ansible-playbook /etc/ansible/playbook.yml -i /etc/ansible/hosts --private-key $key
                    """
                 }
                 }
             }
 }     
}

              
         
                      

