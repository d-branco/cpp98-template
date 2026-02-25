/* ************************************************************************** */
/*                                          ::::::::    ::::::::   :::::::::  */
/*   main.cpp                             :+:    :+:  :+:    :+:  :+:         */
/*                                             +:+         :+:   :+:          */
/*   github.com/d-branco                    +#+         +#+      +#+#+#+      */
/*                                       +#+         +#+              +#+     */
/*   Created: 2026/02/25 20:52:12      #+#         #+#      +#+        #+#    */
/*   Updated: 2026/02/25 20:52:12     #########  #########  ###      ###      */
/*                                                            ########        */
/* ************************************************************************** */

#include "header.hpp"

#ifndef TESTING
int main()
{
	Harl::debug("level  1");
	Harl::info("level  2");
	Harl::warning("level  3");
	Harl::error("level  4");

	std::cout << "end of main()\n";
	return (EXIT_SUCCESS);
}

#else  // if TESTING
TEST_CASE("main():	placeholder")
{
	CHECK(true == true);
	CHECK(42 != 225);
}
#endif // TESTING
