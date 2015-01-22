# encoding: utf-8

# Produces and returns simple Robocode grammar.
def simple_grammar

  # We want to evolve the body for each of the event handlers,
  # however they each have their own unique set of local variables,
  # so we can't use a single set of grammar rules to represent
  # them all.
  #
  # You can find a list of the different events within Robocode online at:
  # http://robocode.sourceforge.net/docs/robocode/robocode/Event.html
  local_variables = {

    # The main run statement has no local variables.
    'm_run'               => {},

    # Take a look at the API for the "onHitWall" event handler online at:
    # http://robocode.sourceforge.net/docs/robocode/robocode/HitWallEvent.html
    'm_on_hit_wall'  => {

      # A list of the local variables of type "double" within this event handler.
      'double' => [
        'e.getBearing()'
      ]

    }

  }

  # Construct the base grammar.
  grammar = {

    # Building blocks.
    'digit'     => [
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
    ],
    'nz_digit'  => [
      '1', '2', '3', '4', '5', '6', '7', '8', '9'
    ],
    'fractional' => [
      '<digit>',
      '<digit><digit>'
    ],

    # Literals.
    'int(literal)' => [
      '<nz_digit><int(literal)>',
      '<digit>'
    ],
    'double(literal)' => [
      '<int(literal)>.<fractional>'
    ],
    'boolean(literal)' => [
      'true',
      'false'
    ],

    # Globals.
    'int(global)' => [
      '<int(literal)>',
      'getNumRounds()',
      'getNumSentries()',
      'getOthers()'
    ],
    'double(global)' => [
      'getX()',
      'getY()',
      'getVelocity()',
      'getHeight()',
      'getHeading()',
      'getEnergy()',
      'getGunHeading()',
      'getGunCoolingRate()',
      'getBattleFieldHeight()',
      'getBattleFieldWidth()',
      'getGunHeat()',
      'getRadarHeading()',
      'getTime()'
    ],

    # Class body.
    'main' => ['
      // This is run in its own thread and is responsible for performing
      // the majority of the actions of simpler tanks.
      public void run() {

        // You could perform some initialisation on your
        // tank here, such as setting each of its colours.

        while (true) {
          <m_run>

          // This statement executes all of the actions at once.
          // Without it, the robot would never do anything!
          execute();
        }

      }

      // This method is called when a robot is spotted by the radar.
      public void onScannedRobot(ScannedRobotEvent e) {
        fire(1);
      }

      // This method is called when the robot bumps into a wall.
      public void onHitWall(HitWallEvent e) {
        <m_on_hit_wall>
      }

      // Can you extend this to cover other event handlers?
    ']

  }

  # Construct the grammar rules for each event handler (e.g. onHitWall, onScannedRobot).
  local_variables.each_pair do |method, variables|

    # Local variables available within this event handler.
    grammar["int(#{method})"]     = variables["int"].to_a + grammar["int(global)"]
    grammar["double(#{method})"]  = variables["double"].to_a + grammar["double(global)"]
    grammar["boolean(#{method})"] = variables["boolean"].to_a + [
      "<boolean(literal)>",
      "<bexp(#{method})>"
    ]
  
    # Boolean expression, using local variables.
    grammar["bexp(#{method})"] = [
      "<bexp_term(#{method})>"
    ]
    grammar["bexp_term(#{method})"] = [
      "<numeric(#{method})> == <numeric(#{method})>",
      "<numeric(#{method})> != <numeric(#{method})>",
      "<numeric(#{method})> >  <numeric(#{method})>",
      "<numeric(#{method})> >= <numeric(#{method})>",
      "<numeric(#{method})> <  <numeric(#{method})>",
      "<numeric(#{method})> <= <numeric(#{method})>"
    ]

    # Returns a numeric type.
    grammar["numeric(#{method})"] = [
      "<int(#{method})>",
      "<double(#{method})>"
    ]

    # Constructs a block of statements in the context of this particular
    # event handler.
    grammar["statements(#{method})"] = [
      "<statement(#{method})>\n<statements(#{method})>",
      "<statement(#{method})>"
    ]

    # Constructs a single statement in the context of this event handler.
    grammar["statement(#{method})"] = [
      "if (<boolean(#{method})>) {\n<statements(#{method})>\n}\nelse {\n<statements(#{method})>\n}",
      "<action(#{method})>;"
    ]

    # Performs an action within the context of this event handler.
    #
    # For a list of possible actions, take a look at:
    # http://robocode.sourceforge.net/docs/robocode/robocode/AdvancedRobot.html
    #
    # Which other actions might improve the performance of your robot?
    # Are any actions redundant? Would removing these actions improve the
    # performance of your robot too? Experiment!
    grammar["action(#{method})"] = [
      "setAhead(<double(#{method})>)",
      "setBack(<double(#{method})>)",
      "setStop()",
      "setResume()",
      "setTurnRight(<double(#{method})>)",
      "setTurnLeft(<double(#{method})>)",
      "setTurnGunLeft(<double(#{method})>)",
      "setTurnGunRight(<double(#{method})>)",
      "setTurnRadarLeft(<double(#{method})>)",
      "setTurnRadarRight(<double(#{method})>)",
      "setAdjustGunForRobotTurn(<boolean(#{method})>)",
      "setAdjustRadarForRobotTurn(<boolean(#{method})>)",
      "setAdjustRadarForGunTurn(<boolean(#{method})>)",
      "setFire(<double(#{method})>)"
    ]

    # Entry point for the body of this particular event handler.
    grammar[method] = [
      "<statements(#{method})>"
    ]

  end

  return grammar

end
