
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

package AUS::Host::File;

use AUS::Host::Generic;
use strict;
our @ISA = qw(AUS::Host::Generic);

if ($^O eq "MSWin32") {
  require AUS::Host::File::Win32;
}
else  {
  require AUS::Host::File::POSIX;
}

sub new {
    my ($class, @p) = @_;
    my $self = AUS::Host::Generic->new($class, @p);

    die("$class requires filename option!\n") unless ($self{'filename'});
    die('Could not read file '.$self{'filename'}."!\n") unless (-r $self{'filename'});

    return $self;
}

1;
