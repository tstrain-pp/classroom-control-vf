class profiles::wordpress {
  include wordpress
  include mysql::server
  include apache
}
