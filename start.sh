#!/bin/sh
#-------------------------------------------------------------------------------
# Copyright (C) 2017 Eurotech.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# 
# Contributors:
#    Eurotech - initial API and implementation
#-------------------------------------------------------------------------------

nohup node ./node-rest-proxy/rest-proxy.js &
/opt/eclipse/kura/bin/start_kura.sh
