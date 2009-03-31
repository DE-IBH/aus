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

package AUS::Config;

use XML::LibXML;
use AUS::Client::Generic;
use AUS::Host::Generic;
use strict;

my $xml_cfgfile = shift || die "Usage: $0 <config.xml>\n";
die "Could not read config file!\n" unless (-r $xml_cfgfile);

my $xml_parser = XML::LibXML->new();
my $xml_dom = $xml_parser->parse_file($xml_cfgfile);

&parse_settings($xml_dom, '/aus/settings/*');
die "no secret set, aborting\n" unless(defined($main::config{'secret'}) && $main::config{'secret'} ne '');

&parse_hosts($xml_dom, '/aus/hosts/use');

sub parse_settings() {
	my ($ctx, $xpath) = @_;

	my $res = $ctx->findnodes($xpath);
	die "config file: empty XPath node list: $xpath\n" unless ($res->isa('XML::LibXML::NodeList'));

	foreach my $nctx ($res->get_nodelist) {
		$main::config{$nctx->localname} = $nctx->textContent;
	}
}

sub parse_hosts() {
	my ($ctx, $xpath) = @_;

	my $res = $ctx->findnodes($xpath);
	die "config file: empty XPath node list: $xpath\n" unless ($res->isa('XML::LibXML::NodeList'));

	foreach my $nctx ($res->get_nodelist) {
		my $pkg = $nctx->findvalue("\@name");
		
		eval("require $pkg;");
		die($@) if $@;

		eval("push(\@main::hosts, new $pkg(\$nctx));");
		die($@) if $@;
	}
}

1;
