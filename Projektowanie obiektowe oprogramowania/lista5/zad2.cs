public class CaesarStream : Stream
{
  private Stream _innerStream;
  private int _shift;

  public CaesarStream(Stream innerStream, int shift)
  {
    _innerStream = innerStream;
    _shift = shift;
  }

  public override void Write(byte[] buffer, int offset, int count)
  {
    byte[] transformed = new byte[count];
    for (int i = 0; i < count; i++)
    {
      // modulo 256, aby zapewnić zawijanie
      transformed[i] = (byte)((buffer[offset + i] + _shift) % 256);
    }
    _innerStream.Write(transformed, 0, count);
  }

  public override int Read(byte[] buffer, int offset, int count)
  {
    byte[] temp = new byte[count];
    int bytesRead = _innerStream.Read(temp, 0, count);
    for (int i = 0; i < bytesRead; i++)
    {
      // dodajemy 256 przed modulo, aby uniknąć ujemnych wartości
      buffer[offset + i] = (byte)(((temp[i] - _shift) + 256) % 256);
    }
    return bytesRead;
  }

  // Przekazujemy metody do wewnętrznego strumienia
  public override bool CanRead => _innerStream.CanRead;
  public override bool CanSeek => _innerStream.CanSeek;
  public override bool CanWrite => _innerStream.CanWrite;
  public override long Length => _innerStream.Length;
  public override long Position
  {
    get { return _innerStream.Position; }
    set { _innerStream.Position = value; }
  }
  public override void Flush() => _innerStream.Flush();
  public override long Seek(long offset, SeekOrigin origin) => _innerStream.Seek(offset, origin);
  public override void SetLength(long value) => _innerStream.SetLength(value);
}
