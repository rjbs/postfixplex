use strict;
use warnings;
use Net::SMTP;

my $smtp = Net::SMTP->new(
  'playground',
  Port  => 25,
  Debug => 1,
);

CMD: {
  last CMD unless $smtp->mail('sender@example.com');
  last CMD unless $smtp->to('recipient@example.com');
  last CMD unless $smtp->data;
  last CMD unless $smtp->datasend("Message-Id: <$$-$^T\@example.com>\n");
  last CMD unless $smtp->datasend("\n");
  last CMD unless $smtp->datasend("Body\n");
  last CMD unless $smtp->dataend;
}

$smtp->quit;
