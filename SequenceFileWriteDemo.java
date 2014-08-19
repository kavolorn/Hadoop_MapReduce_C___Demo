import java.io.IOException;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.SequenceFile;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.typedbytes.TypedBytesWritable;

// (Taken to our project from 
// http://stackoverflow.com/questions/5377118/how-to-convert-txt-file-to-hadoops-sequence-file-format )
//White, Tom (2012-05-10). Hadoop: The Definitive Guide (Kindle Locations 5375-5384). OReilly Media - A. Kindle Edition. 

public class SequenceFileWriteDemo { 
  
  private static final Integer[] keys = {1,1,1,2,2,2,3,3,3};
  private static final Double[][] values = {
    {1.1, 1.2, 1.3},
    {1.2, 1.3, 1.4},
    {1.3, 1.4, 1.5},
    {2.1, 2.2, 2.3},
    {3.1, 3.2, 3.3},
    {4.1, 4.2, 4.3},
    {3.1, 3.2, 3.3},
    {3.2, 3.3, 3.4},
    {3.3, 3.4, 3.5}};

  public static void main( String[] args) throws IOException { 
    String uri = args[0];
    Configuration conf = new Configuration();
    FileSystem fs = FileSystem.get(URI.create(uri), conf);
    Path path = new Path(uri);
    TypedBytesWritable key = new TypedBytesWritable();
    TypedBytesWritable value = new TypedBytesWritable();
    SequenceFile.Writer writer = null;
    try { 
      writer = SequenceFile.createWriter( fs, conf, path, key.getClass(), value.getClass(), 
                                          org.apache.hadoop.io.SequenceFile.CompressionType.NONE);
      for (int i = 0; i < keys.length; i++) { 
        key.setValue(keys[i]);
        //java.util.Vector<Double> nval = new java.util.Vector<Double>(3);
        java.util.ArrayList<Double> nval = new java.util.ArrayList<Double>();
        for (int j = 0; j<values[i].length; j++){
          nval.add(values[i][j]);
        }
        value.setValue(nval);
        writer.append(key,value); 
      } 
    } finally 
      { IOUtils.closeStream( writer); 
      } 
  } 
}
