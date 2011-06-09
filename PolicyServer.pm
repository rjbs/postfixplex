use strict;
use warnings;
package PolicyServer;
use base qw(Net::Server::PreFork);

use Data::GUID qw(guid_string);
use Sys::Hostname;
use Log::Dispatchouli::Global '$Logger' => { init => {
  ident     => 'PolicyServer',
  facility  => undef,
  to_stderr => 1,
} };

our $use_envelope = 1;

sub _get_input {
  my ($self) = @_;

  local $/ = "\n\n";
  my $input = <STDIN>;
  return $input;
}

sub _reply {
  print $_[1];
}

sub process_request {
  my ($self) = (@_);
  local $Logger = $Logger->proxy({ proxy_prefix => guid_string . ": " });

  $Logger->log("processing new request");

  my %a = map { split /=/, $_, 2 } split /\n+/, $self->_get_input;

  unless (keys %a) {
    $Logger->log("got empty attribute list; giving up");
    return;
  }

  $Logger->log([ '%s: attr in: %s', $a{protocol_state}, \%a ]);

  $self->_reply("action=DUNNO\n\n");
}

1;
