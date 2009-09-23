
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

AUS::Client::Generic - Perl AUS extension base class for host shutdowns.

=head1 SYNOPSIS

  use AUS::Client::Generic;

=head1 DESCRIPTION

AUS::Client::Generic is the abstract base class. All implementations
should inherit AUS::Client::Generic.

=head1 METHODS

=over 4

=cut

package AUS::Client::Generic;

use XML::LibXML;
use strict;
use warnings;

use constant AUS_CLIENT_FAILED  => 0;
use constant AUS_CLIENT_OK      => 1;
use constant AUS_CLIENT_UNKNOWN => 2;

=item my $client = AUS::Client::Generic->new($ctx);

I<abstract> This abstract constructor expects a L<XML::LibXML::NodeList>
which contains the configuration of the L<AUS::Client> implementation.

=cut

sub new {
    my ($class, $ctx) = @_;
    my $action = $ctx->nodeName;

    my $self = {
	_class => $class,
    };

    # Read default config
    my $res = $ctx->findnodes('/aus/templates/'.$action."[\@name = '$class']/*");
    if ($res->isa('XML::LibXML::NodeList')) {
	foreach my $n ($res->get_nodelist) {
	    ${$self}{$n->nodeName} = $n->textContent;
        }
    }

    # Read config
    $res = $ctx->findnodes("*");
    if ($res->isa('XML::LibXML::NodeList')) {
	foreach my $n ($res->get_nodelist) {
	    ${$self}{$n->nodeName} = $n->textContent;
        }
    }

    bless $self, $class;
    return $self;
}

=item my $res = $client->do_shutdown;

I<abstract> This function shutdowns a host. The function should
return AUS_CLIENT_FAILED if the shutdown has failed, AUS_CLIENT_OK if the shutdown was
successfully initiated or AUS_CLIENT_UNKNOWN if the result is unknown.

=cut

sub do_shutdown {
    my ($self) = @_;

    warn(${$self}{_class} . " did not override do_shutdown method!\n");

    return AUS_CLIENT_FAILED;
}

=item my $res = $client->check_shutdown;

I<abstract> This function should check the configuration. The function should
return AUS_CLIENT_FAILED if the check has failed, AUS_CLIENT_OK if the check was
successfully or AUS_CLIENT_UNKNOWN if the check result is unknown / not implemented.

=cut

sub check_shutdown {
    my ($self) = @_;

    warn(${$self}{_class} . " did not override check_shutdown method!\n");

    return AUS_CLIENT_UNKNOWN;
}

=pod

=back

=head1 SEE ALSO

L<aus(1)>, L<ausd(1)>

=head1 AUTHOR

Thomas Liske <liske@ibh.de>

=head1 COPYRIGHT

Copyright 2009 by IBH IT-Service GmbH [http://www.ibh.de/]

=cut

1;
