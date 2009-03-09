
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

package AUS::Host::File:POSIX;

use AUS::Host::Generic;
use strict;
our @ISA = qw(AUS::Host::File);

sub new {
    my ($class, @p) = @_;
    my $self = AUS::Host::File->new($class, @p);

    $self{'inotify'} = Linux::Inotify2->new()
	or die "Unable to create new inotify object: $!";
    Event->io(
		fd =>$self{'inotify'}->fileno,
		poll => 'r',
		cb => sub { $self{'inotify'}->poll }
    );

    $inotify->watch ($self{'filename'}, IN_CLOSE_WRITE, sub {
	my $e = shift;
	my $name = $e->fullname;
	
	if($e->IN_CLOSE_WRITE) {
	    print "$name was written\n";
	}
    });

    return $self;
}

sub getHosts {
    my ($self) = @_;

    warn(${$self}{_class} . " did not override getXMLhosts method!\n");
}

1;
