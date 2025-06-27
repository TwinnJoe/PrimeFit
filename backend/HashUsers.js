// hashUsers.js
import bcrypt from 'bcryptjs';

const users = [
  { user_id: 90001, username: 'Jane Smith', password: 'User1' },
];

const hashPasswords = async () => {
  for (const user of users) {
    const hashedPassword = await bcrypt.hash(user.password, 10); // 10 is the salt rounds
    console.log(
      `(${user.user_id}, '${user.username}', '${hashedPassword}'),`
    );
  }
};

hashPasswords();
