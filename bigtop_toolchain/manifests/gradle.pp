# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class bigtop_toolchain::gradle {

  include bigtop_toolchain::deps

  exec {"/usr/bin/wget http://services.gradle.org/distributions/gradle-2.7-bin.zip":
    cwd     => "/usr/src",
    require => Package[$packages::pkgs],
    unless  => "/usr/bin/test -f /usr/src/gradle-2.7-bin.zip",
  }

  exec {'/usr/bin/unzip -x -o /usr/src/gradle-2.7-bin.zip':
    cwd         => '/usr/local',
    refreshonly => true,
    subscribe   => Exec["/usr/bin/wget http://services.gradle.org/distributions/gradle-2.7-bin.zip"],
    require     => Exec["/usr/bin/wget http://services.gradle.org/distributions/gradle-2.7-bin.zip"],
  }

  file {'/usr/local/gradle':
    ensure  => link,
    target  => '/usr/local/gradle-2.7',
    require => Exec['/usr/bin/unzip -x -o /usr/src/gradle-2.7-bin.zip'],
  }
}
