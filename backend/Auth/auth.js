import jwt from 'jsonwebtoken';
JWT_SECRET = 'fdd6733c6254ae9e10a2dd003741e0ae8b9f1a5726face4067c6a4d74d9a9d385df81db438ee3ff0ded74b9bd46fc44a426f22418262d20ff65cd4976d5e789b'

export const authenticateToken = (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1]; // expects 'Bearer <token>'

  if (!token) return res.status(401).json({ error: 'No token provided' });

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: 'Invalid or expired token' });

    req.user = user;
    next();
  });
};
