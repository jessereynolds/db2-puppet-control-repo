# WebSphere appserver profile
class profile::websphere_appserver {
  file { [
    '/opt/log',
    '/opt/log/websphere',
    '/opt/log/websphere/appserverlogs',
    '/opt/log/websphere/applogs',
    '/opt/log/websphere/wasmgmtlogs',
  ]:
    ensure => 'directory',
    owner  => 'wsadmin',
    group  => 'wsadmins',
  }

  $repository = '/opt/IBM/Shared/repository.config'

  class { 'websphere_application_server':
    user     => 'webadmin',
    group    => 'webadmins',
    base_dir => '/opt/IBM',
  }

  websphere_application_server::instance { 'WebSphere85':
    target       => '/opt/IBM/WebSphere/AppServer',
    package      => 'com.ibm.websphere.NDTRIAL.v85',
    version      => '8.5.5000.20130514_1044',
    profile_base => '/opt/IBM/WebSphere/AppServer/profiles',
    repository   => $repository,
  }

  ibm_pkg { 'WebSphere_8554':
    ensure        => 'present',
    package       => 'com.ibm.websphere.NDTRIAL.v85',
    version       => '8.5.5004.20141119_1746',
    target        => '/opt/IBM/WebSphere/AppServer',
    repository    => $repository,
    package_owner => 'wsadmin',
    package_group => 'wsadmins',
    require       => Websphere_application_server::Instance['WebSphere85'],
  }

  ibm_pkg { 'Java7':
    ensure        => 'present',
    package       => 'com.ibm.websphere.IBMJAVA.v71',
    version       => '7.1.2000.20141116_0823',
    target        => '/opt/IBM/WebSphere/AppServer',
    repository    => $repository,
    package_owner => 'wsadmin',
    package_group => 'wsadmins',
    require       => Websphere_application_server::Package['WebSphere_8554'],
  }

}
