class homebrew::install {

  file { '/usr/local/Homebrew':
    ensure  => directory,
    owner   => $homebrew::user,
    group   => $homebrew::group,
    mode    => '0755',
  }

  exec { 'install-homebrew':
    cwd       => '/usr/local',
    command   => "/usr/bin/su ${homebrew::user} -c '/bin/bash -o pipefail -c \"/usr/bin/curl -skSfL https://github.com/homebrew/brew/tarball/master | /usr/bin/tar xz -m --strip 1\"'",
    creates   => '/usr/local/bin/brew',
    logoutput => on_failure,
    timeout   => 0,
    require   => File['/usr/local/Homebrew'],
  } ~>
  file { '/usr/local/bin/brew':
    owner => $homebrew::user,
    group => $homebrew::group,
    mode  => '0775',
  }

}
