#!/usr/bin/perl

=head1 NAME

bot-basicbot-pluggable.pl - A standard Bot::BasicBot::Pluggable script

=head1 DESCRIPTION

A standard Bot::BasicBot::Pluggable interface. You can /query the bot to
load in more modules. Change the admin password ASAP - 
See perldoc L<Bot::BasicBot::Pluggable::Auth> for details of this.

=head1 USAGE

  bot-basicbot-pluggable.pl --nick MyBot --server irc.perl.org
=head2 SEE ALSO

Bot::BasicBot::Pluggable

=cut

use warnings;
use strict;
use Bot::BasicBot::Pluggable;
use Getopt::Long;

my $nick = "mindtest";
my $server = "london.irc.perl.org";

my $result = GetOptions(
  "nick=s" => \$nick,
  "server=s" => \$server,
);

unless ($result and $nick and $server) {
  warn "Usage: $0 --nick <nick> --server <server>\n";
  exit 1;
}

my $bot = Bot::BasicBot::Pluggable->new(
  channels => [ ],
  server => $server,
  nick => $nick,

  store => {
    type => "DBI",
    dsn => "dbi:mysql:test",
    user => 'root',
    table => "basicbot",
  },
);

# nice to load this one explicitly
$bot->load("Auth");

# Loader lets you tell the bot to load other modules.
$bot->load("Loader");

$bot->run();

