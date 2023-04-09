{ pkgs, lib, fetchFromGitHub, rustPlatform }:

  {
	aichat = rustPlatform.buildRustPackage rec {
	  pname = "aichat";
	  version = "0.8.0";

	  src = fetchFromGitHub {
	    owner = "sigoden";
	    repo = pname;
	    rev = version;
	    hash = "sha256-E/QslRDeifFHlHUELv9rYHjfCAB1yXXiXlWOyPNkfps=";
	  };

	  cargoHash = "sha256-7TTHBeZ68G6k5eHBL1zDGsYiTyx27fBbN7Rl9AiZTng=";
	  buildInputs = [
    		pkgs.darwin.apple_sdk.frameworks.Security
  	  ];

	  doCheck = false;

	  meta = with lib; {
	    description = "Using ChatGPT/GPT-3.5/GPT-4 in the terminal";
	    homepage = "https://github.com/sigoden/aichat";
	    license = licenses.mit;
	    maintainers = []; 
	  };
	};
}
