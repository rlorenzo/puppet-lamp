class cron {
     package { "vixie-cron":
          category => "sys-process",
          ensure => present,
     }
     service { "vixie-cron":
          name => "crond",
          ensure => running,
          enable => true,
          hasstatus => true,
          require => Package["vixie-cron"]
     }
}