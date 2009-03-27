# aus - Agentless Universal Shutdown
#
# $Id$
#
# Authors:
#   Thomas Liske <liske@ibh.de>
#
# Copyright Holder:
#   2009 (C) IBH IT-Service GmbH [http://www.ibh.de/]
#
# License:
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this package; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
#

use AUS::Logging;
package AUS::Logging::Syslog;
use strict;
use Sys::Syslog;
our @ISA = qw(AUS::Logging);

sub new {
    my ($class) = @_;
    my $self = AUS::Logging->new($class);

    bless $self, $class;

	openlog('ausd', 'pid', Sys::Syslog::LOG_DAEMON);

    return $self;
}

sub info {
    my ($self, $m) = @_;
	
	syslog(Sys::Syslog::LOG_INFO, $m)
}

sub warning {
    my ($self, $m) = @_;
	
	syslog(Sys::Syslog::LOG_WARNING, $m)
}

sub error {
    my ($self, $m) = @_;
	
	syslog(Sys::Syslog::LOG_ERR, $m)
}

1;
