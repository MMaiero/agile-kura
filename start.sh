#!/bin/sh
#-------------------------------------------------------------------------------
# Copyright (C) 2017, 2018 Eurotech.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License 2.0
# which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
# 
# Contributors:
#    Eurotech - initial API and implementation
#-------------------------------------------------------------------------------

cd ./node-rest-proxy
npm install
cd ..

nohup node ./node-rest-proxy/rest-proxy.js &
/opt/eclipse/kura/bin/start_kura.sh
