
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

=pod

=head1 NAME

AUS::Client::CIFS - Perl AUS extension for host shutdowns by CIFS RPC calls.

=head1 SYNOPSIS

  use AUS::Client::CIFS;

=head1 DESCRIPTION

AUS::Client::CIFS provides an L<AUS::Client::Generic> implementation
using CIFS RPC.

=head1 METHODS

=over 4

=cut

package AUS::Client::CIFS;

use AUS::Client::Generic;
use strict;
use warnings;
our @ISA = qw(AUS::Client::Generic);

=pod

=back

=head1 SEE ALSO

L<AUS::Client::Generic>, L<net(8)>,
L<aus(1)>, L<ausd(1)>

=head1 AUTHOR

Thomas Liske <liske@ibh.de>

=head1 COPYRIGHT

Copyright 2009 by IBH IT-Service GmbH [http://www.ibh.de/]

=cut

1;
