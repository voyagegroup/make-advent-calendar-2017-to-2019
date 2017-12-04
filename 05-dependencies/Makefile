user=katzchang

logins: $(user).json
	jq -r ".[].login" $^

$(user).json:
	curl "https://api.github.com/users/$(user)/orgs" > $@

clean:
	rm -f $(user).json
