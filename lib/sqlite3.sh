#!/bin/bash

#    Sqlite3 Database Manager - sqlite3.sh
#    Copyright (C) 2022  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# return codes;
# 0: success.
# 1: requirement not found.
# 2: null variable.

sqlite3:is_db() {
    command -v sqlite3 &> /dev/null || return 1
    command -v file &> /dev/null || return 1
    #?
}

sqlite3:create:table() {
    command -v sqlite3 &> /dev/null || return 1
    local file=""
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --table)
                local value=""
                shift # shift it self
                [[ -n "${1}" ]] && local table="${1}" || return 2
                shift # shift the table name
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --table)
                            local 
                            break
                        ;;
                        -t)
                            shift
                            while [[ "${#}" -gt 0 ]] ; do
                                case "${1}" in
                                    --table|-i)
                                        break
                                    ;;
                                    *)
                                        local value+="${1} TEXT,"
                                        shift
                                    ;;
                                esac
                            done
                        ;;
                        -i)
                            shift
                            while [[ "${#}" -gt 0 ]] ; do
                                case "${1}" in
                                    --table|-t)
                                        break
                                    ;;
                                    *)
                                        local value+="${1} INTEGER,"
                                        shift
                                    ;;
                                esac
                            done
                        ;;
                        *)
                            shift
                        ;;
                    esac
                done
                local databases+=("${table}(${value%,*})")
            ;;
            *)
                local file="${1}"
                shift
            ;;
        esac
    done

    if [[ -n "${file}" ]] ; then
        #echo -e "File=${file[@]}\nTable=${table[@]}\ndb=${databases[@]}"
        :
    else
        echo "'filename' could not be null!"
        return 2
    fi
}

sqlite3:create:table ${@}