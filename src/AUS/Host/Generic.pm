
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

package AUS::Host::Generic;

use XML::LibXML;
use strict;

sub new {
    my ($class, $ctx) = @_;

    my $self = {
	_class => $class,
    };

    # Read parameter
    $res = $ctx->findnodes("*");
    if ($res->isa('XML::LibXML::NodeList')) {
	foreach my $n ($res->get_nodelist) {
	    ${$self}{$n->nodeName} = $n->textContent;
        }
    }

    bless $self, $class;
    return $self;
}

sub getXMLhosts {
    my ($self) = @_;

    warn(${$self}{_class} . " did not override getXMLhosts method!\n");
}

1;
