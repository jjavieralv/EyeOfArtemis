import bcrypt


def encrypt_password_htpasswd_fixeddollar(password):
    bcrypted = bcrypt.hashpw(password.encode(
        "utf-8"), bcrypt.gensalt(rounds=12)).decode("utf-8").replace("$", "$$")
    return f"{bcrypted}"


class FilterModule(object):
    def filters(self):
        return {
            'encrypt_password_htpasswd_fixeddollar': encrypt_password_htpasswd_fixeddollar,
        }
