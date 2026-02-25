/* ************************************************************************** */
/*                                          ::::::::    ::::::::   :::::::::  */
/*   Harl.hpp                             :+:    :+:  :+:    :+:  :+:         */
/*                                             +:+         :+:   :+:          */
/*   github.com/d-branco                    +#+         +#+      +#+#+#+      */
/*                                       +#+         +#+              +#+     */
/*   Created: 2026/02/25 20:52:12      #+#         #+#      +#+        #+#    */
/*   Updated: 2026/02/25 20:52:12     #########  #########  ###      ###      */
/*                                                            ########        */
/* ************************************************************************** */

#ifndef HARL_HPP
#define HARL_HPP

#include <iostream>
#include <string>

#define AEC_DEBUG	"\033[90m"
#define AEC_INFO	"\033[36m"
#define AEC_WARNING "\033[93m"
#define AEC_ERROR	"\033[91m"
#define AEC_RESET	"\033[0m"

class Harl
{
  public:
	Harl();
	Harl(const Harl &other);
	Harl &operator=(const Harl &other);
	~Harl();

	enum LogLevel
	{
		DEBUG	= 1,
		INFO	= 2,
		WARNING = 3,
		ERROR	= 4
	};

#ifdef HARL
	static void debug(const std::string &msg);
	static void info(const std::string &msg);
	static void warning(const std::string &msg);
	static void error(const std::string &msg);
#else
	static void debug(const std::string &msg)
	{
		(void) msg;
	}

	static void info(const std::string &msg)
	{
		(void) msg;
	}

	static void warning(const std::string &msg)
	{
		(void) msg;
	}

	static void error(const std::string &msg)
	{
		(void) msg;
	}
#endif // HARL
};

#endif // HARL_HPP
