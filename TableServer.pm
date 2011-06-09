use strict;
use warnings;
package TableServer;
use base qw(Net::Server::PreFork);

use Data::GUID qw(guid_string);
use Sys::Hostname;
use Log::Dispatchouli::Global '$Logger' => { init => {
  ident     => 'TableServer',
  facility  => undef,
  to_stderr => 1,
} };

sub _get_input {
  my ($self) = @_;

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

  my $query = $self->_get_input;
  chomp $query;

  $Logger->log("Query for: $query");

  $self->_reply("200 OK\n");
}

1;
