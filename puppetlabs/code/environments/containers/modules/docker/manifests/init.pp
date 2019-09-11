class docker {

Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

	if $facts['hostname'] == 'docker' {
        	$env = "containers"
	} else {
        	$env = "production"
	}

if $facts['hostname'] == 'docker' {
	 case $osfamily {
                "redhat": {
			$pacotes = ['yum-utils',' device-mapper-persistent-data','lvm2]
			package {
		                $pacotes:
                		        ensure => present
         		}

			exec{"stable repo":
                                command => " yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
			}

		        package {'docker-ce':
                        		ensure => present
                        }

			exec{"running the hello-world image":
                                command => "docker run hello-world"
                        }


		}

		"debian": {
			exec{"Update the apt package index":
                                command => "apt-get update"
                        }
			
			exec{"Install packages to allow apt to use a repository over HTTPS":
                                command => "apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common"
			}
				
			exec{"Add Docker’s official GPG key":
				command => "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"

			exec{"set up the stable repository":
				command => 'add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic -cs) stable"'

			exec{"Update the apt package index":
                                command => "apt-get update"
                        }

			exec{"Install the latest version of Docker Engine - Community":
                                command => "apt-get install docker-ce"
                        }
			
			exec{"running the hello-world image":
                                command => "docker run hello-world"
                        }

                }

	}




}








}




















