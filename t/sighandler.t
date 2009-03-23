#!perl -w

# Startup Test:
# $Id: sighandler.t,v 1.2 2006/11/27 13:42:52 roland Exp $

use Schedule::Cron;
use Test::More tests => 1;

$| = 1;

SKIP: {
    eval { alarm 0 };
    skip "alarm() not available", 1 if $@;

    # Check, whether an already installed signalhandler is called
    $SIG{CHLD} = sub { 
        pass;
        exit;
    };
    
    $SIG{ALRM} = sub { 
        fail;
        exit;
    };
    
    
    my $cron = new Schedule::Cron(sub { sleep(1) });
    $cron->add_entry("* * * * * */2");
    alarm(5);
    $cron->run;
}