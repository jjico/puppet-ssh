type Ssh::Root::Authentication = Variant[
  Boolean,
  Enum[
    'yes',
    'no',
    'true',
    'false',
    'without-password',
    'prohibit-password',
    'force-commands-only'
  ]
]
