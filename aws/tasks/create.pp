ec2_instance { 'wmg-module-create-01':
  ensure          => running,
  region          => 'eu-central-1',
  image_id        => 'ami-dd3c0f36',
  instance_type   => 't2.micro',
  subnet          => 'tse-wmg-daybook-01',
  key_name        => 'wmg-mbp',
  security_groups => 'ssh-only',
  tags            => {
    lifetime => '1d',
  }
}

