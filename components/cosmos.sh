function cosmos_emulator_cert () {
  EMULATOR_HOST=localhost
  EMULATOR_PORT=8081
  EMULATOR_CERT_PATH=/c/tmp/cosmos_emulator.crt
  openssl s_client -connect ${EMULATOR_HOST}:${EMULATOR_PORT} </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $EMULATOR_CERT_PATH
}