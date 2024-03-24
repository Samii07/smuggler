#include <cryptopp/rabbit.h>

int main()
{
	auto key = std::vector<uint8_t>(CryptoPP::RabbitWithIV::KEYLENGTH, 0x00);
	auto iv = std::vector<uint8_t>(CryptoPP::RabbitWithIV::IV_LENGTH, 0x00);
	auto buffer = std::vector<uint8_t>(0x20, 0x00);
	auto expected = std::vector<uint8_t>{ 0xED, 0xB7, 0x05, 0x67, 0x37, 0x5D, 0xCD, 0x7C, 0xD8, 0x95, 0x54, 0xF8, 0x5E, 0x27, 0xA7, 0xC6, 0x8D, 0x4A, 0xDC, 0x70, 0x32, 0x29, 0x8F, 0x7B, 0xD4, 0xEF, 0xF5, 0x04, 0xAC, 0xA6, 0x29, 0x5F };

	CryptoPP::RabbitWithIV::Encryption enc;
	enc.SetKeyWithIV(key.data(), key.size(), iv.data(), iv.size());

	enc.ProcessData(buffer.data(), buffer.data(), buffer.size());

	CRYPTOPP_ASSERT(memcmp(buffer.data(), expected.data(), expected.size()) == 0);

	return 0;