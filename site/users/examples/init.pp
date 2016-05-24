class users { 
  user {'newuser' :
    home => '/home/newuser',
    uid => '10100',
  }
}
