# encoding: utf-8

def variable_grammar

  grammar = {
      "digit" => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
      "nz_digit" => ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      "fractional" => ["<digit>", "<digit><digit>"],
      "int(literal)" => ["<nz_digit><int(literal)>", "<digit>"],
      "double(literal)" => ["<int(literal)>.<fractional>", "<int(literal)>"],
      "boolean(literal)" => ["true", "false"],
      "main" => ["
                 \n
                private int number = 0;\n
                private boolean bool = true;\n
                 \n
                private void setNumber(int newNumber) {\n
                    number = newNumber;\n
                }\n
                 \n
                private int getNumber() {\n
                    return number;\n
                }\n
                 \n
                private void setBool(boolean newBool) {\n
                    bool = newBool;\n
                }\n
                 \n
                private boolean getBool(){\n
                    return bool;\n
                }\n

                 \n    // This is run in its own thread and is responsible for performing\n
      // the majority of the actions of simpler tanks.\n
      public void run() {\n
                 \n          while (true) {\n
            <m_run>\n
                 \n
          // This statement executes all of the set actions at once.\n
          execute();\n
        }\n
                 \n
      }\n
                 \n
      // This method is called when a robot is spotted by the radar.\n
      public void onScannedRobot(ScannedRobotEvent e) {\n
        fire(<double(m_on_scanned_robot)>);\n
      }\n
                 \n
      // This method is called when the robot bumps into a wall.\n
      public void onHitWall(HitWallEvent e) {\n
        <m_on_hit_wall>\n
      }\n
                 \n
      // This method is called when the robot is hit by a bullet.\n
      public void onHitByBullet(HitByBulletEvent e) {\n
        <m_on_hit_by_bullet>\n
      }\n
                 \n
      // This method is called when one of this robots bullets hits.\n
      public void onBulletHit(BulletHitEvent e) {\n
        <m_on_bullet_hit>\n
      }\n
                 \n
      // This method is called when a this robot hits another robot.\n
      public void onHitRobot(HitRobotEvent e) {\n
        <m_on_hit_robot>\n
      }\n
                 \n
                 "],

      "int(m_run)" => ["<int(literal)>", "getNumber()"],
      "double(m_run)" => ["getVelocity()", "getHeading()", "getEnergy()", "getGunHeading()", "getGunHeat()", "getRadarHeading()", "<double(literal)>"],
      "boolean(m_run)" => ["<bexp(m_run)>", "getBool()"],
      "bexp(m_run)" => ["<bexp_term(m_run)>"],
      "bexp_term(m_run)" => ["<numeric(m_run)> == <numeric(m_run)>", "<numeric(m_run)> != <numeric(m_run)>", "<numeric(m_run)> >  <numeric(m_run)>", "<numeric(m_run)> >= <numeric(m_run)>", "<numeric(m_run)> <  <numeric(m_run)>", "<numeric(m_run)> <= <numeric(m_run)>"],
      "numeric(m_run)" => ["<int(m_run)>", "<double(m_run)>"],
      "statements(m_run)" => ["<statement(m_run)>\n<statements(m_run)>", "<statement(m_run)>"],
      "statement(m_run)" => ["if (<boolean_m_run>) {\n<statements(m_run)>\n}", "if (<boolean(m_run)>) {\n<statements(m_run)>\n}\nelse {\n<statements(m_run)>\n}", "<action(m_run)>;"],
      "action(m_run)" => ["setAhead(<double(m_run)>)", "setBack(<double(m_run)>)", "setTurnRight(<double(m_run)>)", "setTurnLeft(<double(m_run)>)", "setTurnGunLeft(<double(m_run)>)", "setTurnGunRight(<double(m_run)>)", "setTurnRadarLeft(<double(m_run)>)", "setTurnRadarRight(<double(m_run)>)", "setFire(<double(m_run)>)", "setNumber(<int(m_run)>)", "setBool(<boolean(m_run)>)"],
      "m_run" => ["<statements(m_run)>"],

      "int(m_on_hit_wall)" => ["<int(literal)>", "getNumber()"],
      "double(m_on_hit_wall)" => ["e.getBearing()", "getVelocity()", "getHeading()", "<double(literal)>"],
      "boolean(m_on_hit_wall)" => ["<bexp(m_on_hit_wall)>", "getBool()"],
      "bexp(m_on_hit_wall)" => ["<bexp_term(m_on_hit_wall)>"],
      "bexp_term(m_on_hit_wall)" => ["<numeric(m_on_hit_wall)> == <numeric(m_on_hit_wall)>", "<numeric(m_on_hit_wall)> != <numeric(m_on_hit_wall)>", "<numeric(m_on_hit_wall)> >  <numeric(m_on_hit_wall)>", "<numeric(m_on_hit_wall)> >= <numeric(m_on_hit_wall)>", "<numeric(m_on_hit_wall)> <  <numeric(m_on_hit_wall)>", "<numeric(m_on_hit_wall)> <= <numeric(m_on_hit_wall)>"],
      "numeric(m_on_hit_wall)" => ["<int(m_on_hit_wall)>", "<double(m_on_hit_wall)>"],
      "statements(m_on_hit_wall)" => ["<statement(m_on_hit_wall)>\n<statements(m_on_hit_wall)>", "<statement(m_on_hit_wall)>"],
      "statement(m_on_hit_wall)" => ["if (<boolean_m_on_hit_wall>) {\n<statements(m_on_hit_wall)>\n}", "if (<boolean(m_on_hit_wall)>) {\n<statements(m_on_hit_wall)>\n}\nelse {\n<statements(m_on_hit_wall)>\n}", "<action(m_on_hit_wall)>;"],
      "action(m_on_hit_wall)" => ["ahead(<double(m_on_hit_wall)>)", "back(<double(m_on_hit_wall)>)", "turnRight(<double(m_on_hit_wall)>)", "turnLeft(<double(m_on_hit_wall)>)", "setNumber(<int(m_on_hit_wall)>)", "setBool(<boolean(m_on_hit_wall)>)"],
      "m_on_hit_wall" => ["<statements(m_on_hit_wall)>"],

      "int(m_on_hit_by_bullet)" => ["<int(literal)>", "getNumber()"],
      "double(m_on_hit_by_bullet)" => ["e.getBearing()", "e.getHeading()", "e.getVelocity()", "e.getPower()", "getVelocity()", "getHeading()", "getEnergy()", "<double(literal)>"],
      "boolean(m_on_hit_by_bullet)" => ["<bexp(m_on_hit_by_bullet)>", "getBool()"],
      "bexp(m_on_hit_by_bullet)" => ["<bexp_term(m_on_hit_by_bullet)>"],
      "bexp_term(m_on_hit_by_bullet)" => ["<numeric(m_on_hit_by_bullet)> == <numeric(m_on_hit_by_bullet)>", "<numeric(m_on_hit_by_bullet)> != <numeric(m_on_hit_by_bullet)>", "<numeric(m_on_hit_by_bullet)> >  <numeric(m_on_hit_by_bullet)>", "<numeric(m_on_hit_by_bullet)> >= <numeric(m_on_hit_by_bullet)>", "<numeric(m_on_hit_by_bullet)> <  <numeric(m_on_hit_by_bullet)>", "<numeric(m_on_hit_by_bullet)> <= <numeric(m_on_hit_by_bullet)>"],
      "numeric(m_on_hit_by_bullet)" => ["<int(m_on_hit_by_bullet)>", "<double(m_on_hit_by_bullet)>"],
      "statements(m_on_hit_by_bullet)" => ["<statement(m_on_hit_by_bullet)>\n<statements(m_on_hit_by_bullet)>", "<statement(m_on_hit_by_bullet)>"],
      "statement(m_on_hit_by_bullet)" => ["if (<boolean(m_on_hit_by_bullet)>) {\n<statements(m_on_hit_by_bullet)>\n}", "if (<boolean(m_on_hit_by_bullet)>) {\n<statements(m_on_hit_by_bullet)>\n}\nelse {\n<statements(m_on_hit_by_bullet)>\n}", "<action(m_on_hit_by_bullet)>;"],
      "action(m_on_hit_by_bullet)" => ["ahead(<double(m_on_hit_by_bullet)>)", "back(<double(m_on_hit_by_bullet)>)", "turnRight(<double(m_on_hit_by_bullet)>)", "turnLeft(<double(m_on_hit_by_bullet)>)", "turnGunLeft(<double(m_on_hit_by_bullet)>)", "turnGunRight(<double(m_on_hit_by_bullet)>)", "turnRadarLeft(<double(m_on_hit_by_bullet)>)", "turnRadarRight(<double(m_on_hit_by_bullet)>)", "fire(<int(m_on_hit_by_bullet)>)", "setNumber(<int(m_on_hit_by_bullet)>)", "setBool(<boolean(m_on_hit_by_bullet)>)"],
      "m_on_hit_by_bullet" => ["<statements(m_on_hit_by_bullet)>"],

      "int(m_on_bullet_hit)" => ["<int(literal)>", "getNumber()"],
      "double(m_on_bullet_hit)" => ["e.getEnergy()", "getVelocity()", "getHeading()", "getEnergy()", "getGunHeading()", "getGunHeat()", "getRadarHeading()", "<double(literal)>"],
      "boolean(m_on_bullet_hit)" => ["<bexp(m_on_bullet_hit)>", "getBool()"],
      "bexp(m_on_bullet_hit)" => ["<bexp_term(m_on_bullet_hit)>"],
      "bexp_term(m_on_bullet_hit)" => ["<numeric(m_on_bullet_hit)> == <numeric(m_on_bullet_hit)>", "<numeric(m_on_bullet_hit)> != <numeric(m_on_bullet_hit)>", "<numeric(m_on_bullet_hit)> >  <numeric(m_on_bullet_hit)>", "<numeric(m_on_bullet_hit)> >= <numeric(m_on_bullet_hit)>", "<numeric(m_on_bullet_hit)> <  <numeric(m_on_bullet_hit)>", "<numeric(m_on_bullet_hit)> <= <numeric(m_on_bullet_hit)>"],
      "numeric(m_on_bullet_hit)" => ["<int(m_on_bullet_hit)>", "<double(m_on_bullet_hit)>"],
      "statements(m_on_bullet_hit)" => ["<statement(m_on_bullet_hit)>\n<statements(m_on_bullet_hit)>", "<statement(m_on_bullet_hit)>"],
      "statement(m_on_bullet_hit)" => ["if (<boolean_m_on_bullet_hit>) {\n<statements(m_on_bullet_hit)>\n}", "if (<boolean(m_on_bullet_hit)>) {\n<statements(m_on_bullet_hit)>\n}\nelse {\n<statements(m_on_bullet_hit)>\n}", "<action(m_on_bullet_hit)>;"],
      "action(m_on_bullet_hit)" => ["ahead(<double(m_on_bullet_hit)>)", "back(<double(m_on_bullet_hit)>)", "turnRight(<double(m_on_bullet_hit)>)", "turnLeft(<double(m_on_bullet_hit)>)", "turnGunLeft(<double(m_on_bullet_hit)>)", "turnGunRight(<double(m_on_bullet_hit)>)", "turnRadarLeft(<double(m_on_bullet_hit)>)", "turnRadarRight(<double(m_on_bullet_hit)>)", "fire(<int(m_on_bullet_hit)>)", "setNumber(<int(m_on_bullet_hit)>)", "setBool(<boolean(m_on_bullet_hit)>)"],
      "m_on_bullet_hit" => ["<statements(m_on_bullet_hit)>"],

      "int(m_on_hit_robot)" => ["<int(literal)>", "getNumber()"],
      "double(m_on_hit_robot)" => ["e.getBearing()", "e.getEnergy()", "getVelocity()", "getHeading()", "getEnergy()", "getGunHeading()", "getGunHeat()", "getRadarHeading()", "<double(literal)>"],
      "boolean(m_on_hit_robot)" => ["e.isMyFault()", "<bexp(m_on_hit_robot)>", "getBool()"],
      "bexp(m_on_hit_robot)" => ["<bexp_term(m_on_hit_robot)>"],
      "bexp_term(m_on_hit_robot)" => ["<numeric(m_on_hit_robot)> == <numeric(m_on_hit_robot)>", "<numeric(m_on_hit_robot)> != <numeric(m_on_hit_robot)>", "<numeric(m_on_hit_robot)> >  <numeric(m_on_hit_robot)>", "<numeric(m_on_hit_robot)> >= <numeric(m_on_hit_robot)>", "<numeric(m_on_hit_robot)> <  <numeric(m_on_hit_robot)>", "<numeric(m_on_hit_robot)> <= <numeric(m_on_hit_robot)>"],
      "numeric(m_on_hit_robot)" => ["<int(m_on_hit_robot)>", "<double(m_on_hit_robot)>"],
      "statements(m_on_hit_robot)" => ["<statement(m_on_hit_robot)>\n<statements(m_on_hit_robot)>", "<statement(m_on_hit_robot)>"],
      "statement(m_on_hit_robot)" => ["if (<boolean_m_on_hit_robot>) {\n<statements(m_on_hit_robot)>\n}", "if (<boolean(m_on_hit_robot)>) {\n<statements(m_on_hit_robot)>\n}\nelse {\n<statements(m_on_hit_robot)>\n}", "<action(m_on_hit_robot)>;"],
      "action(m_on_hit_robot)" => ["ahead(<double(m_on_hit_robot)>)", "back(<double(m_on_hit_robot)>)", "turnRight(<double(m_on_hit_robot)>)", "turnLeft(<double(m_on_hit_robot)>)", "fire(<int(m_on_hit_robot)>)", "setNumber(<int(m_on_hit_robot)>)", "setBool(<boolean(m_on_hit_robot)>)"],
      "m_on_hit_robot" => ["<statements(m_on_hit_robot)>"],

      "double(m_on_scanned_robot)" => ["e.getBearing()", "e.getDistance()", "e.getEnergy()", "e.getHeading()", "e.getVelocity()", "getVelocity()", "getHeading()", "getEnergy()", "getGunHeading()", "getGunHeat()", "getRadarHeading()", "<double(literal)>"],
  }

  return grammar

end
