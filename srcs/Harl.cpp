#include "../include/Harl.hpp"

Harl::Harl()
{
}

Harl::Harl(const Harl &other)
{
	*this = other;
}

Harl &Harl::operator=(const Harl &other)
{
	(void) other;
	return (*this);
}

Harl::~Harl()
{
}

#ifdef HARL
void Harl::debug(const std::string &msg)
{
	if (HARL <= DEBUG)
	{
		std::cerr << AEC_DEBUG << "==DEBUG== " << msg << AEC_RESET << std::endl;
	}
}

void Harl::info(const std::string &msg)
{
	if (HARL <= INFO)
	{
		std::cerr << AEC_INFO << "_I_N_F_O_ " << msg << AEC_RESET << std::endl;
	}
}

void Harl::warning(const std::string &msg)
{
	if (HARL <= WARNING)
	{
		std::cerr << AEC_WARNING << "_WARNING_ " << msg << AEC_RESET
				  << std::endl;
	}
}

void Harl::error(const std::string &msg)
{
	if (HARL <= ERROR)
	{
		std::cerr << AEC_ERROR << "[[ERROR]] " << msg << AEC_RESET << std::endl;
	}
}
#endif // HARL
