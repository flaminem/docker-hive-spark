#!/bin/bash

./init.sh

su $USER -c "$HIVE_HOME/bin/beeline --showHeader=true -u jdbc:hive2://localhost:10000"

